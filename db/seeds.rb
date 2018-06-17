# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Clinic.destroy_all

Clinic.create([{name: 'Glasnevin Family Practice', location: 'Glasnevin, Dublin'}, {name: 'Sligo Clinic', location: 'Cornageeha, Sligo'},
{name: 'Dundrum', location: 'Dundrum Town Center, Dublin'}, {name: 'Ardaravan Clinic', location: 'Lifford, Donegal'}, {name: 'Mullingar Millmount Medical Center', location: 'Mullingar, Westmeath'},
{name: 'The Meridian Clinic', location: 'Blanchardstown, Dublin'}])


p "Created #{Clinic.count} clinics"

Condition.destroy_all

Condition.create([{name: "GOOD"}, {name: "FAIR"}, {name: "CRITICAL"}, {name: "UNDETERMINED"}])


p "Created #{Condition.count} conditions"