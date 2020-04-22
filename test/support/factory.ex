defmodule Cookpod.Factory do
  use ExMachina.Ecto, repo: Cookpod.Repo

  use Cookpod.RecipleFactory
  use Cookpod.UserFactory
end
