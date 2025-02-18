require "rails_helper"

RSpec.describe Spots::Show::ShowSerializer, type: :serializer do
  describe "#serialize_spots" do
    subject { described_class.new(spot, user: user).as_json }
    let!(:spot) { FactoryBot.create(:spot, :with_images) }
    let!(:fishing_type1) { FactoryBot.create(:fishing_type) }
    let!(:spot_fishing_type) { FactoryBot.create(:spot_fishing_type, spot_id: spot.id, fishing_type_id: fishing_type1.id) }
    let!(:spot_fishing_types) { spot.fishing_types << [fishing_type1] }
    let!(:fish) { FactoryBot.create(:fish) }
    let!(:spot_fishing_types) { spot.fish << [fish] }

    context "引数のユーザーと釣り場のユーザーに関して" do
      context "一致している場合" do
        let(:user) { spot.user }

        it "editableにはtrueが返ること" do
          expect(subject).to eq({
                               id: spot.id,
                               name: spot.name,
                               latitude: spot.latitude,
                               longitude: spot.longitude,
                               description: spot.description,
                               location: spot.location.name,
                               fish: [fish.name],
                               fishing_types: [fishing_type1.name],
                               images: ActiveModelSerializers::SerializableResource.new(spot.images.blobs.order(created_at: :desc, id: :asc), each_serializer: ::Spots::Show::ImageSerializer).as_json,
                               editable: true,
                             })
        end
      end

      context "一致していない場合" do
        let(:user) { FactoryBot.build(:user) }

        it "editableにはfalseが返る" do
          expect(subject[:editable]).to eq(false)
        end
      end
    end
  end
end
