defmodule Cookpod.AccountsTest do
  use Cookpod.DataCase

  alias Cookpod.Accounts

  describe "users" do
    alias Cookpod.Accounts.User

    @valid_attrs %{
      email: "some@yandex.ru",
      password: "some password",
      password_confirmation: "some password"
    }
    @update_attrs %{email: "some_updated@yandex.ru"}
    @invalid_attrs %{email: nil, password: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert users = Accounts.list_users()
      assert length(users) == length([user])
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert db_user = Accounts.get_user!(user.id)
      assert db_user.email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some@yandex.ru"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some_updated@yandex.ru"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
