require_relative('model/bounty')
require('pry-byebug')

bounty1 = Bounty.new(
  {
    'name' => 'Dog',
    'species' => 'Hooman',
    'danger_level' => 'Low',
    'bounty_value' => '5'
  }
)

bounty2 = Bounty.new(
  {
    'name' => 'Sheba',
    'species' => 'Thundercat',
    'danger_level' => 'Medium',
    'bounty_value' => '10'
  }
)

bounty1.save()
bounty2.save()

bounty1.danger_level = "ermagerddddd"
bounty1.update()

p Bounty.all_names("Sheba")
p Bounty.all_ids('34')

#bounty1.delete()
