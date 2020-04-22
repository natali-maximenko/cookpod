defmodule Cookpod.RecipleFactory do
  alias Faker

  defmacro __using__(_opts) do
    quote do
      def reciple_factory do
        %Cookpod.Catalog.Reciple{
          title: Faker.Name.title(),
          description: Faker.Food.description(),
          image: nil,
          state: "draft"
        }
      end
    end
  end
end
