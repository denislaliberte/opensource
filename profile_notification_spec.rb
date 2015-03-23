
module RSpec::Core::Notifications 
    RSpec.describe ProfileNotification do

    subject { ProfileNotification.new(0, examples, 1) }

    let(:examples) { 
      example1.metadata
      example2.metadata
      example1.run
      example2.run
      [ example1, example2]
    }

    let(:example1) {
        RSpec.describe "slow example" do
          it "asdf" do
            sleep(1)
            expect(1).to eq(2)
          end
        end
    }

    let(:example2){
        RSpec.describe "slow context" do
          before(:context) do
            sleep(1.5)
          end
          it "qwer" do
            expect(2).to eq(1)
          end
        end
    }

    it { expect(subject.slowest_examples().first()).to eq("slow context") }
  end
end
