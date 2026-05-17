module Nhs
  class SyncService
    class << self
      include Nhs::ApiClient

      def call(url:, model:)
        client = connection
        while url
          parsed = fetch(url, client)
          process(parsed['significantLink'], model)
          url = next_page_url(parsed['relatedLink'])
        end
      end

      private

      def fetch(url, client)
        response = client.get(url)
        JSON.parse(response.body)
      end

      def process(conditions, model)
        conditions.each do |condition|
          next unless condition['articleStatus'] == 'published'

          model.find_or_create_by!(source_url: condition['url']) do |c|
            c.name = condition['name']
            c.description = condition['description']
            c.slug = condition['url'].split('/').compact_blank.last
          end
        end
      end

      def next_page_url(related_links)
        related_links.find { |link| link['name'] == 'Next Page' }&.[]('url')
      end
    end
  end
end
