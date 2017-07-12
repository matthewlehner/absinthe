defmodule Absinthe.Execution.SubscriptionTest do
  use Absinthe.Case, async: true

  defmodule Schema do
    use Absinthe.Schema

    query do
      #Query type must exist
    end

    subscription do
      field :thing, :string do
        arg :client_id, non_null(:id)
        resolve fn
          %{client_id: id}, _ ->
            {:ok, "subscribed-#{id}"}
        end
      end
    end

  end

  context "subscriptions" do

    @query """
    subscription SubscribeToThing($clientId: ID!) {
      thing(clientId: $clientId)
    }
    """
    it "errors for the moment" do
      assert_raise(RuntimeError, fn ->
        run(@query, Schema, variables: %{"clientId" => "abc"})
      end)
    end
  end

end
