FactoryGirl.define do
  factory :entry do
    body <<-"EOS"
    Intro:
    GbM7(9) | F7(#9) | Bbm7(9) | Db9

    A melody:
    Bbm7(11) | Bbm7(11) | Bm7(11) | Bm7(11)
    EOS

    trait :with_sounds do
      body <<-"EOS"
      Intro:
      GbM7(9){3n3324} | F7(#9){1n2212} | Bbm7(9){6n6668} | Db9{n6566n}

      A melody:
      Bbm7(11){6n664n} | Bbm7(11){6n664n} | Bm7(11){7n775n} | Bm7(11){7n775n}
      EOS
    end
  end
end
