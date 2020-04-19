# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cookpod.Repo.insert!(%Cookpod.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Cookpod.Accounts
alias Cookpod.Repo

existed_user = Repo.get_by(Accounts.User, email: "admin@cookpod.com")

if is_nil(existed_user) do
  {:ok, _} =
    Accounts.create_user(%{
      email: "admin@cookpod.com",
      password: "admin",
      password_confirmation: "admin"
    })
end
