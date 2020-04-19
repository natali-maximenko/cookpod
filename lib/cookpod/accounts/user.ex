defmodule Cookpod.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "users" do
    field :email, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required [:email, :password, :password_confirmation]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 4)
    |> validate_change(:email, &validate_email/2)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp validate_email(_, value) do
    [_, domain] = String.split(value, ~r/@/)
    domain = String.to_charlist(domain)
    servers = :inet_res.lookup(domain, :in, :mx)

    if Enum.empty?(servers) do
      [title: "not valid email"]
    else
      []
    end
  end

  defp put_password_hash(
         %Ecto.Changeset{
           valid?: true,
           changes: %{email: _, password: password, password_confirmation: _}
         } = changeset
       ) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
