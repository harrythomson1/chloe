module Nhs
  class SyncService
    class << self
      def call
        url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
        while url
          parsed = fetch(url)
          process(parsed['significantLink'])
          url = next_page_url(parsed['relatedLink'])
        end
      end

      private

      def fetch(url)
        response = Faraday.get(url) do |req|
          req.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
        end
        JSON.parse(response.body)
      end

      def process(conditions)
        conditions.each do |condition|
          next unless condition['articleStatus'] == 'published'

          Condition.find_or_create_by!(
            name: condition['name'],
            description: condition['description'],
            source_url: condition['url'],
            slug: condition['url'].split('/').compact_blank.last
          )
        end
      end

      def next_page_url(related_links)
        related_links.find { |link| link['name'] == 'Next Page' }&.[]('url')
      end
    end
  end
end
