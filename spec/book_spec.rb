require "spec_helper"

describe Book do
  describe(".all") do
    it("is empty at first") do
      expect(Book.all()).to(eq([]))
    end
  end
end
