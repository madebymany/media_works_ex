defmodule MediaWorks.UtilsTest do
  use ExUnit.Case
  alias MediaWorks.Utils

  test "#camelize will transform an atom" do
    assert Utils.camelize(:one_two_three) == :oneTwoThree
  end

  test "#camelize will transform a string" do
    assert Utils.camelize("one_two_three") == "oneTwoThree"
  end

  test "#underscore will transform an atom" do
    assert Utils.underscore(:oneTwoThree) == :one_two_three
  end

  test "#underscore will transform a string" do
    assert Utils.underscore("oneTwoThree") == "one_two_three"
  end

  test "#camelize_keys will work with shallow maps" do
    assert Utils.camelize_keys(%{ one_two_three: "one_two_three" }) ==
           %{ oneTwoThree: "one_two_three" }
  end

  test "#camelize_keys will work with lists" do
    assert Utils.camelize_keys([%{ one_two_three: "one_two_three" }]) ==
           [%{ oneTwoThree: "one_two_three" }]
  end

  test "#camelize_keys will work with deep maps" do
    input = %{
      one_two_three: %{
        two_three_four: "yes"
      }
    }

    expected = %{
      oneTwoThree: %{
        twoThreeFour: "yes"
      }
    }

    assert Utils.camelize_keys(input) == expected
  end

  test "#camelize_keys will work with lists in a deep map" do
    input = %{
      one_two_three: [%{
        two_three_four: "yes"
      }]
    }

    expected = %{
      oneTwoThree: [%{
        twoThreeFour: "yes"
      }]
    }

    assert Utils.camelize_keys(input) == expected
  end

  test "#underscore_keys will work with shallow maps" do
    assert Utils.underscore_keys(%{ oneTwoThree: "one_two_three" }) ==
           %{ one_two_three: "one_two_three" }
  end

  test "#underscore_keys will work with lists" do
    assert Utils.underscore_keys([%{ oneTwoThree: "one_two_three" }]) ==
           [%{ one_two_three: "one_two_three" }]
  end

  test "#underscore_keys will work with deep maps" do
    input = %{
      oneTwoThree: %{
        twoThreeFour: "yes"
      }
    }

    expected = %{
      one_two_three: %{
        two_three_four: "yes"
      }
    }

    assert Utils.underscore_keys(input) == expected
  end

  test "#underscore_keys will work with lists in a deep map" do
    input = %{
      oneTwoThree: [%{
        twoThreeFour: "yes"
      }]
    }

    expected = %{
      one_two_three: [%{
        two_three_four: "yes"
      }]
    }

    assert Utils.underscore_keys(input) == expected
  end
end