# frozen_string_literal: true

RSpec.describe PostcodeChecker::NormalisePostcode do
  let(:postcode) { ' SE1 7QD ' }

  it 'removes spaces and downcase the postcode' do
    expect(described_class.call(postcode)).to eql('se17qd')
  end
end
