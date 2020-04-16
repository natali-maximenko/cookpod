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

    def reciple_fixture(attrs \\ %{}) do
      {:ok, reciple} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_reciple()

      reciple
    end

    test "list_reciples/0 returns all reciples" do
      reciple = reciple_fixture()
      assert Catalog.list_reciples() == [reciple]
    end

    test "get_reciple!/1 returns the reciple with given id" do
      reciple = reciple_fixture()
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
      reciple = reciple_fixture()
      assert {:ok, %Reciple{} = reciple} = Catalog.publish_reciple(reciple)
      assert reciple.state == "published"
    end

    test "update_reciple/2 with valid data updates the reciple" do
      reciple = reciple_fixture()
      assert {:ok, %Reciple{} = reciple} = Catalog.update_reciple(reciple, @update_attrs)
      assert reciple.description == "some updated description"
      assert reciple.title == "some updated title"
    end

    test "update_reciple/2 with invalid data returns error changeset" do
      reciple = reciple_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_reciple(reciple, @invalid_attrs)
      assert reciple == Catalog.get_reciple!(reciple.id)
    end

    test "delete_reciple/1 deletes the reciple" do
      reciple = reciple_fixture()
      assert {:ok, %Reciple{}} = Catalog.delete_reciple(reciple)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_reciple!(reciple.id) end
    end

    test "change_reciple/1 returns a reciple changeset" do
      reciple = reciple_fixture()
      assert %Ecto.Changeset{} = Catalog.change_reciple(reciple)
    end
  end
end
