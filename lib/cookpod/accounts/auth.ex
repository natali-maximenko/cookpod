defmodule Cookpod.Accounts.Auth do
  alias Bcrypt
  alias Cookpod.Accounts.User
  alias Cookpod.Repo

  def authenticate_user(email, plain_text_password) do
    User
    |> Repo.get_by(email: email)
    |> check_password(plain_text_password)
  end

  defp check_password(nil, _), do: {:error, "Incorrect email"}

  defp check_password(user, plain_text_password) do
    Bcrypt.check_pass(user, plain_text_password)
  end
end
