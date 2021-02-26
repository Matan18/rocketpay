defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true
  alias Rocketpay.Users.Create
  alias Rocketpay.User

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Mateus",
        password: "123456",
        nickname: "MatanTeste",
        email: "novomateus@matandriola.com",
        age: 27
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)
      assert %User{name: "Mateus", age: 27, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Mateus",
        nickname: "MatanTeste",
        email: "novomateus@matandriola.com",
        age: 15
      }

      {:erro, changeset} = Create.call(params)

      expect_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expect_response
    end
  end
end
