# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sesion do
    tema "MyString"
    hora_inicio "2013-12-18 13:21:31"
    hora_termino "2013-12-18 13:21:31"
    fecha "2013-12-18 13:21:31"
    tipo "MyString"
    direccion "MyString"
    comentario "MyString"
  end
end
