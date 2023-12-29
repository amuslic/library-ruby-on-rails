class AddTriggerToDecreaseHardCopies < ActiveRecord::Migration[7.1]
    def change
      # Create a trigger after insert on the loans table
      execute <<-SQL
        CREATE TRIGGER decrease_hard_copies
        AFTER INSERT ON loans
        BEGIN
          UPDATE books
          SET hard_copies = hard_copies - 1
          WHERE id = NEW.book_id;
        END;
      SQL
    end
end
