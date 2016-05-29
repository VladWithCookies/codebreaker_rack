require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }
    let(:secret_code) { game.instance_variable_get(:@secret_code) }

    before do
      game.start
    end

    describe "#start" do
      it "generates secret code" do
        expect(secret_code).not_to be_empty
      end

      it "saves 4 numbers secret code" do
        expect(secret_code.size).to eq(4)
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(secret_code).to match(/[1-6]+/)
      end
    end

    describe "#check_guess" do
      it "marks + if digit and position is right" do
        expect(game.check_guess(secret_code)).to eq("++++")
      end

      it "marks - if only digit is right" do
        game.instance_variable_set(:@secret_code, "1234")
        expect(game.check_guess("2143")).to eq("----")
      end

      it "make win true if guess is ++++" do
        game.check_guess(secret_code)
        expect(game.win).to eq(true)
      end

      [
        ['1234', '1245', '++-'], ['1234', '1111', '+'], ['1234','1432', '++--'],
        ['1234', '4565', '-'], ['5556', '1553', '++'], ['1234', '2125', '--'],
        ['4561', '3561', '+++'], ['4562', '2653', '---'], ['2345', '3455', '+--']
      ].each do |x|
        it "return right #{x[2]} mark for #{x[0]} code and #{x[1]} guess" do
          game.instance_variable_set(:@secret_code, x[0])
          expect(game.check_guess(x[1])).to eq(x[2])
        end
      end
    end

    describe "#hint" do
      it "give position of some digit in secret code" do
        game.instance_variable_set(:@secret_code, "1234")
        expect(game.hint).to match(/\b[1-4]/)
      end

      it "decrement number of hints by one" do
        game.hint
        expect(game.hints).to eq(0)
      end
    end
  end
end