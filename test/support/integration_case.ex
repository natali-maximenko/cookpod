defmodule CookpodWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CookpodWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
