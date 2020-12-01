require 'spec_helper'

describe NessusTest::Host do
  let(:host1_xml) { File.expand_path('../../fixtures/files/host-01.xml', __FILE__) }

  before do
    doc = Nokogiri::XML(File.read(host1_xml))
    @host = NessusTest::Host.new(doc.xpath('/NessusClientData_v2/Report/ReportHost').first)
  end

  # These are the properties we need to support:
  # host.name                 The name given at scan time, usually an IP address
  # host.ip                   The ip address of the host
  # host.fqdn                 The full qualified domain name of the host
  # host.operating_system     The OS of the system if detected
  # host.mac_address          The mac address if the scanned system was on the same subnet
  # host.netbios_name         The netbios name of the system
  # host.scan_start_time      The date/time the scan started
  # host.scan_stop_time       The date/time the scan ended
  it 'Nessus::Host responds to all the expected fields' do
    expect(@host.name).to eq('10.0.0.1')
    expect(@host.scan_start_time).to eq('Tue Aug  9 09:50:18 2011')
  end

  it 'provides access to each of its ReportItems' do
    report_items = @host.report_items
    report_items.each { |item| expect(item).to be_a(NessusTest::ReportItem) }
  end
end
