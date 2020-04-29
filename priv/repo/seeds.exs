# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Repo.insert!(%Cookpod.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Cookpod.Accounts
alias Cookpod.Catalog.{Ingredient, Product, Reciple}
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

leek = Repo.insert!(%Product{name: "leek", carbs: 14.15, fats: 0.3, proteins: 1.5})
garlic = Repo.insert!(%Product{name: "garlic", carbs: 29.9, fats: 0.5, proteins: 6.5})
broccoli = Repo.insert!(%Product{name: "broccoli", carbs: 6.64, fats: 0.37, proteins: 2.82})
butter = Repo.insert!(%Product{name: "butter", carbs: 0.06, fats: 81.11, proteins: 0.85})
thyme = Repo.insert!(%Product{name: "thyme", carbs: 0.0, fats: 0.0, proteins: 0.0})
flour = Repo.insert!(%Product{name: "flour", carbs: 70.6, fats: 1.1, proteins: 10.3})
milk = Repo.insert!(%Product{name: "milk", carbs: 4.7, fats: 3.2, proteins: 3.0})
macaroni = Repo.insert!(%Product{name: "dried macaroni", carbs: 75.3, fats: 1.4, proteins: 14.63})

parmesan =
  Repo.insert!(%Product{name: "Parmesan cheese", carbs: 3.22, fats: 25.83, proteins: 35.75})

cheddar = Repo.insert!(%Product{name: "Cheddar cheese", carbs: 1.28, fats: 33.14, proteins: 24.9})
spinach = Repo.insert!(%Product{name: "spinach", carbs: 3.63, fats: 0.39, proteins: 2.86})
almonds = Repo.insert!(%Product{name: "almonds", carbs: 16.2, fats: 57.7, proteins: 18.6})

reciple =
  Repo.insert!(%Reciple{
    title: "Greens mac 'n' cheese",
    description: """
    A Friday-night favourite, this is a twist on a comfort classic that uses
    broccoli in two ways – the blitzed-up stalks add colour and punch to the
    sauce, while you enjoy the delicate florets with your pasta. Join the green team!
    """
  })

Repo.insert!(%Ingredient{reciple: reciple, amount: 10, product: leek})
Repo.insert!(%Ingredient{reciple: reciple, amount: 30, product: garlic})
Repo.insert!(%Ingredient{reciple: reciple, amount: 400, product: broccoli})
Repo.insert!(%Ingredient{reciple: reciple, amount: 40, product: butter})
Repo.insert!(%Ingredient{reciple: reciple, amount: 15, product: thyme})
Repo.insert!(%Ingredient{reciple: reciple, amount: 20, product: flour})
Repo.insert!(%Ingredient{reciple: reciple, amount: 90, product: milk})
Repo.insert!(%Ingredient{reciple: reciple, amount: 450, product: macaroni})
Repo.insert!(%Ingredient{reciple: reciple, amount: 30, product: parmesan})
Repo.insert!(%Ingredient{reciple: reciple, amount: 150, product: cheddar})
Repo.insert!(%Ingredient{reciple: reciple, amount: 100, product: spinach})
Repo.insert!(%Ingredient{reciple: reciple, amount: 50, product: almonds})
