defmodule CookpodWeb.Plugs.BasicAuthTest do
  use ExUnit.Case
  alias CookpodWeb.Plugs.BasicAuth

  test "not passing :username raises an error" do
    assert_raise KeyError, fn ->
      BasicAuth.init(password: "secret")
    end
  end

  test "not passing :password raises an error" do
    assert_raise KeyError, fn ->
      BasicAuth.init(username: "user")
    end
  end
end
