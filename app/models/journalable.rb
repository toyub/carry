module Journalable
  def self.create_credit!(order)
    party = order.party
    credit = Credit.create! party: party,
                            order_id: order.id,
                            subject: order.subject,
                            amount: order.amount

    journal_entry = JournalEntry.new  party: party,
                                      journalable: credit,
                                      balance: party.balance.to_f - credit.amount.to_f 
    journal_entry.save!
    party.decrease_balance!(credit.amount)

  end

  def self.create_debit!(payment)
    party = payment.party
    debit = Debit.create! party: party,
                          payment_id: payment.id,
                          subject: payment.subject,
                          amount: payment.amount

    journal_entry = JournalEntry.new  party: party,
                                      journalable: debit,
                                      balance: party.balance.to_f + debit.amount.to_f
    journal_entry.save!
    party.increase_balance!(debit.amount)
  end
end
