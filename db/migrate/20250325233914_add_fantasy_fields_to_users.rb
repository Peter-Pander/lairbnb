class AddFantasyFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :tavern_talk, :text
    add_column :users, :adventuring_profession, :string
    add_column :users, :dream_realm, :string
    add_column :users, :cursed_habit, :string
    add_column :users, :companion_creature, :string
    add_column :users, :age_of_origin, :string
    add_column :users, :trained_at, :string
    add_column :users, :unexpected_quirk, :text
    add_column :users, :useless_talent, :string
    add_column :users, :battle_song, :string
    add_column :users, :tongues_you_speak, :string
    add_column :users, :title_of_your_scroll, :string
    add_column :users, :enchanted_by, :string
    add_column :users, :sleeping_conditions, :string
    add_column :users, :resting_weapon, :string
    add_column :users, :travel_style, :string
    add_column :users, :innkeeping_philosophy, :text
  end
end
