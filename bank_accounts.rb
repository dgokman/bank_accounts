require 'csv'
require 'pry'

class Transaction
  attr_reader :date, :amount, :description, :account

  def initialize(date, amount, description, account)
    @date = date
    @amount = amount
    @description = description
    @account = account
  end

  def deposit?
    if @amount.to_f > 0
      return "DEPOSIT"
    else
      return "WITHDRAWAL"
    end
  end

  def summary
    "#{amount}\t#{deposit?}\t#{date} - #{description}"
  end
  #binding.pry
end



class Account
  attr_reader :name, :starting_balance
  attr_accessor :transactions

  def initialize(starting_balance, name)
    @starting_balance = starting_balance
    @name = name
    @transactions = []
  end

  def current_balance
    @transactions.each do |transaction|
      @starting_balance += transaction["Amount"].to_f
      binding.pry
    end
  end

  def summary
  end
end

accounts = []
transactions = []
CSV.foreach('balances.csv', headers: true) do |row|
  accounts << Account.new(row['Balance'], row['Account'])
  #accounts is now an array of Account objects
  #you can access each method of the Accounts class by accessing an individual object within the array
end

CSV.foreach('bank_data.csv', headers: true) do |row|
  # find the matching account from
  transactions << Transaction.new(row['Date'], row['Amount'], row['Description'], row['Account'])
  #transactions is now an array of Transaction objects
  #you can access each method of the Transactions class by accessing an individual object within the array
end

binding.pry

accounts.each do |account|
  puts "==== #{account.name} ===="
  puts "Starting Balance: #{account.starting_balance}"
  puts "Ending Balance: #{account.current_balance}"
  puts "========"
end
# puts "Ending Balance: #{Account.current_balance}"
# puts
# puts "#{Transactions.summary}"
# puts "========"
# puts
# puts "==== Business Checking ===="
# puts "Starting Balance: #{Account.starting_balance}"
# puts "Ending Balance: #{Account.current_balance}"
# puts
# puts "#{Transactions.summary}"
# puts "========"
