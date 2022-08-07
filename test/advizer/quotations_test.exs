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

  describe "simulations" do
    alias Advizer.Quotations.Simulation

    import Advizer.QuotationsFixtures

    @invalid_attrs %{
      annual_revenue: nil,
      coverage_ceiling_formula: nil,
      deductible_formula: nil,
      enterprise_number: nil,
      legal_name: nil,
      nacebel_codes: nil,
      natural_person: nil
    }

    test "get_simulation!/1 returns the simulation with given id" do
      simulation = simulation_fixture()
      assert Quotations.get_simulation!(simulation.id) == simulation
    end

    test "create_simulation/1 with valid data creates a simulation" do
      valid_attrs = %{
        annual_revenue: 42,
        enterprise_number: "some enterprise_number",
        legal_name: "some legal_name",
        nacebel_codes: [],
        natural_person: true
      }

      assert {:ok, %Simulation{} = simulation} = Quotations.create_simulation(valid_attrs)
      assert simulation.annual_revenue == 42
      assert simulation.enterprise_number == "some enterprise_number"
      assert simulation.legal_name == "some legal_name"
      assert simulation.nacebel_codes == []
      assert simulation.natural_person == true
    end

    test "create_simulation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotations.create_simulation(@invalid_attrs)
    end
  end
end
