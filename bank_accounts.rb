require 'csv'
require 'pry'


class Transactions
  def self.deposit?
    balances = []
      CSV.foreach('bank_data.csv', headers: true) do |row|
        balances << row.to_hash
      end
      balances.each do |balance|
        if balance["Amount"].to_i > 0
     end
    end
  end

  def self.summary
    balances = []
    CSV.foreach('bank_data.csv', headers: true) do |row|
      balances << row.to_hash
    end
    transactions = []
    balances.each do |balance|
      if self.deposit? != true
        amount = balance["Amount"].to_i * -1
        type = 'WITHDRAWAL'
      else
        amount = balance["Amount"].to_i
        type = 'DEPOSIT'
      end
      transactions << "#{amount}\t#{type}\t#{balance["Date"]} - #{balance["Description"]}"
    end
    transactions
  end
end

class Account
  def initialize
    @transactions = Transactions.summary
  end

  def self.starting_balance
    starting_balance = {}
    CSV.foreach('balances.csv', headers: true) do |row|
      starting_balance[row[0]] = row[1].to_i
    end
  end

  def self.current_balance
  end

  def self.summary
    summaries = []
    summaries << @transactions
    binding.pry
  end
end

Account.summary

# puts "==== Purchasing Account ===="
# puts "Starting Balance: #{Account.starting_balance}"
# puts "Ending Balance: #{Account.current_balance}"
# puts
# puts "#{Account.summary}"
# puts "========"
# puts
# puts "==== Business Checking ===="
# puts "Starting Balance: #{Account.starting_balance}"
# puts "Ending Balance: #{Account.current_balance}"
# puts
# puts "#{Account.summary}"
# puts "========"
