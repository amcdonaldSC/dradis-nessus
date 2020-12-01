module Dradis
  module Plugins
    module NessusTest

      class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor

        def post_initialize(args={})
          @nessus_object = (data.name == 'ReportHost') ? ::NessusTest::Host.new(data) : ::NessusTest::ReportItem.new(data)
        end

        def value(args={})
          field = args[:field]

          # fields in the template are of the form <foo>.<field>, where <foo>
          # is common across all fields for a given template (and meaningless).
          _, name = field.split('.')

          if name.end_with?('entries')
            # report_item.bid_entries
            # report_item.cve_entries
            # report_item.xref_entries
            entries = @nessus_object.try(name)
            if entries.any?
              entries.to_a.join("\n")
            else
              'n/a'
            end
          else
            output = @nessus_object.try(name) || 'n/a'

            if field == 'report_item.description' && output =~ /^\s+-/
              format_bullet_point_lists(output)
            else
              output
            end
          end
        end

        private
        def format_bullet_point_lists(input)
          input.split("\n").map do |paragraph|
            if paragraph =~ /(.*)\s+:\s*$/m
              $1 + ':'
            elsif paragraph =~ /^\s+-\s+(.*)$/m
              '* ' + $1.gsub(/\s{3,}/, ' ').gsub(/\n/, ' ')
            else
              paragraph
            end
          end.join("\n")
        end
      end

    end
  end
end
