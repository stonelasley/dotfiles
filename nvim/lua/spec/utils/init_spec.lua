local mock = require('luassert.mock')

describe("utils", function()

  local cut = require('utils')

  describe("is_table", function()
    it("Should identify table", function()
      local table = {}

      --local vim = mock(vim, true)


      local actual =  cut.is_table(table)
      assert.True(actual)

      --assert.stub(vim.inspect).was_called_with(table)
      --mock.revert(vim)
    end)

    it("Should identify non-table", function()
      local types = { 'string', 0, function()  end }

      --local vim = mock(vim, true)

      for _, t in ipairs(types) do
        local actual =  cut.is_table(t)
        assert.False(actual)
      end


      --assert.stub(vim.inspect).was_called_with(table)
      --mock.revert(vim)
    end)

    it("Should identify string", function()
      local types = {'', "string", [[something]] }

      for _, t in ipairs(types) do
        local actual =  cut.is_string(t)
        assert.True(actual)
      end

    end)

    it("Should identify non-string", function()
      local types = { {}, 0, function()  end }

      for _, t in ipairs(types) do
        local actual =  cut.is_string(t)
        assert.False(actual)
      end

    end)



  end)
end)
