defmodule Advizer.QuotationsTest do
  use Advizer.DataCase

  alias Advizer.Quotations

  describe "properties" do
    import Advizer.QuotationsFixtures

    @valid_attrs %{
      code: "12345"
    }

    @invalid_attrs %{
      code: :invalid
    }

    test "upsert_nacebel/1 with valid data creates a nacebel entry" do
      assert {:ok, %Quotations.Nacebel{}} = Quotations.upsert_nacebel(@valid_attrs)
    end

    test "upsert_nacebel/1 with conflicting data returns the existing nacebel" do
      nacebel = nacebel_fixture()

      assert {:ok, %Quotations.Nacebel{} = duplicated} = Quotations.upsert_nacebel(@valid_attrs)

      assert nacebel.code == duplicated.code
    end

    test "upsert_nacebel/1 with invalid data returns a changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotations.upsert_nacebel(@invalid_attrs)
    end

    test "valid_nacebel_codes/1 with valid codes returns a success tuple" do
      nacebel_fixture()
      assert {:ok, []} = Quotations.valid_nacebel_codes(["12345"])
    end

    test "valid_nacebel_codes/1 with invalid codes returns a failing tuple" do
      nacebel_fixture()
      assert {:error, ["11111"]} = Quotations.valid_nacebel_codes(["11111"])
    end
  end
end
