defmodule Cookpod.UserFactory do
  alias Faker.Internet

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Cookpod.Accounts.User{
          email: Internet.email(),
          password: "password",
          password_confirmation: "password",
          password_hash: Bcrypt.hash_pwd_salt("password")
        }
      end
    end
  end
end
