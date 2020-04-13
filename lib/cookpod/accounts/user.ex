defmodule Cookpod.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> validate_required(@required
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 4)
    |> validate_confirmation(:password))
    |> unique_constraint(:email)
  end
end
