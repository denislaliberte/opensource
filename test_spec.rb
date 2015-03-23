
      RSpec.describe "slow before context" do
        before(:context) do
          sleep 0.3
        end
        it "qwer" do
          expect(10).to eq(10)
        end
      end

      RSpec.describe "slow example" do
        it "qwer" do
          sleep 0.2
          expect(10).to eq(10)
        end
      end
