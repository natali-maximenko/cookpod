defmodule Cookpod.Factory do
  use ExMachina.Ecto, repo: Cookpod.Repo

  def user_factory do
    %Cookpod.Accounts.User{
      email: Faker.Internet.email(),
      password: "password",
      password_confirmation: "password",
      password_hash: Bcrypt.hash_pwd_salt("password")
    }
  end

  def reciple_factory do
    %Cookpod.Catalog.Reciple{
      title: Faker.Name.title(),
      description: Faker.Food.description(),
      image: nil,
      state: "draft"
    }
  end
end
