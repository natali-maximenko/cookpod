defmodule Cookpod.CatalogTest do
  use Cookpod.DataCase

  alias Cookpod.Catalog

  describe "reciples" do
    alias Cookpod.Catalog.Reciple

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{
      description: "some updated description",
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, image: nil, title: nil}

    test "list_reciples/0 returns all reciples" do
      reciple = insert(:reciple)
      assert Catalog.list_reciples() == [reciple]
    end

    test "get_reciple!/1 returns the reciple with given id" do
      reciple = insert(:reciple)
      assert Catalog.get_reciple!(reciple.id) == reciple
    end

    test "create_reciple/1 with valid data creates a reciple" do
      assert {:ok, %Reciple{} = reciple} = Catalog.create_reciple(@valid_attrs)
      assert reciple.description == "some description"
      assert reciple.title == "some title"
      assert reciple.state == "draft"
    end

    test "create_reciple/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_reciple(@invalid_attrs)
    end

    test "publish_reciple/1 updates the reciple state" do
      reciple = insert(:reciple)
      assert {:ok, %Reciple{} = reciple} = Catalog.publish_reciple(reciple)
      assert reciple.state == "published"
    end

    test "update_reciple/2 with valid data updates the reciple" do
      reciple = insert(:reciple)
      assert {:ok, %Reciple{} = reciple} = Catalog.update_reciple(reciple, @update_attrs)
      assert reciple.description == "some updated description"
      assert reciple.title == "some updated title"
    end

    test "update_reciple/2 with invalid data returns error changeset" do
      reciple = insert(:reciple)
      assert {:error, %Ecto.Changeset{}} = Catalog.update_reciple(reciple, @invalid_attrs)
      assert reciple == Catalog.get_reciple!(reciple.id)
    end

    test "delete_reciple/1 deletes the reciple" do
      reciple = insert(:reciple)
      assert {:ok, %Reciple{}} = Catalog.delete_reciple(reciple)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_reciple!(reciple.id) end
    end

    test "change_reciple/1 returns a reciple changeset" do
      reciple = insert(:reciple)
      assert %Ecto.Changeset{} = Catalog.change_reciple(reciple)
    end
  end

  describe "products" do
    alias Cookpod.Catalog.Product

    @valid_attrs %{carbs: 42, fats: 42, name: "some name", proteins: 42}
    @update_attrs %{carbs: 43, fats: 43, name: "some updated name", proteins: 43}
    @invalid_attrs %{carbs: nil, fats: nil, name: nil, proteins: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Catalog.create_product(@valid_attrs)
      assert product.carbs == 42
      assert product.fats == 42
      assert product.name == "some name"
      assert product.proteins == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Catalog.update_product(product, @update_attrs)
      assert product.carbs == 43
      assert product.fats == 43
      assert product.name == "some updated name"
      assert product.proteins == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  describe "ingredients" do
    alias Cookpod.Catalog.Ingredient

    @valid_attrs %{amount: 42}
    @update_attrs %{amount: 43}
    @invalid_attrs %{amount: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Catalog.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Catalog.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Catalog.create_ingredient(@valid_attrs)
      assert ingredient.amount == 42
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()

      assert {:ok, %Ingredient{} = ingredient} =
               Catalog.update_ingredient(ingredient, @update_attrs)

      assert ingredient.amount == 43
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Catalog.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Catalog.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Catalog.change_ingredient(ingredient)
    end
  end
end
