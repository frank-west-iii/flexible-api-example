require 'rails_helper'

describe 'GET /v1/contacts' do
  it 'returns a list of contacts' do
    contact = create(:contact)
    contact_two = create(:contact_two)

    get '/v1/contacts'

    expect(response_json).to eq(
      'contacts' => [
        {'name' => contact.name,
         'href' => v1_contact_url(contact) },
         {'name' => contact_two.name,
          'href' => v1_contact_url(contact_two)}])
  end

  it 'returns a list of contacts and includes phones' do
    contact = create(:contact)
    contact_two = create(:contact_two)
    phone = create(:phone, contact: contact)
    phone_two = create(:phone, number: '555-555-1212', contact: contact_two)

    get '/v1/contacts?includes=phones'

    expect(response_json).to eq(
      'contacts' => [
        {'name' => contact.name,
         'href' => v1_contact_url(contact),
         'phones' => [
           {'number' => phone.number}
         ]},
         {'name' => contact_two.name,
          'href' => v1_contact_url(contact_two),
          'phones' => [
            {'number' => phone_two.number}
          ]}])
  end

  it 'returns a list of contacts that matches the search query' do
    contact = create(:contact)
    create(:contact_two)

    get '/v1/contacts?q[name_start]=Rob'

    expect(response_json).to eq(
      'contacts' => [
        {'name' => contact.name,
         'href' => v1_contact_url(contact)}])
  end

  it 'returns a list of contacts that matches the search query and includes phones' do
    contact = create(:contact)
    phone = create(:phone, contact: contact)
    create(:contact_two)

    get '/v1/contacts?q[name_start]=Rob&includes=phones'

    expect(response_json).to eq(
      'contacts' => [
        {'name' => contact.name,
         'href' => v1_contact_url(contact),
         'phones' => [
           {'number' => phone.number }
         ]}])
  end
end

describe 'GET /v1/contacts/:id' do
  it 'returns a contact by :id' do
    contact = create(:contact)

    get "/v1/contacts/#{contact.id}"

    expect(response_json).to eq({
      'contact' => {
        'name' => contact.name,
         'href' => v1_contact_url(contact)}})
  end

  it 'returns a contact by :id and includes phones' do
    contact = create(:contact)
    phone = create(:phone, contact: contact)

    get "/v1/contacts/#{contact.id}?includes=phones"

    expect(response_json).to eq({
      'contact' => {
        'name' => contact.name,
        'href' => v1_contact_url(contact),
        'phones' => [
          'number' => phone.number
        ]}})
  end
end
