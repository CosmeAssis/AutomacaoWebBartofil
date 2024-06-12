import sys
import urllib.parse

def main():
    base_url = sys.argv[1]
    field = sys.argv[2]
    value = sys.argv[3]

    query_params = {
        'searchCriteria[filter_groups][0][filters][0][field]': field,
        'searchCriteria[filter_groups][0][filters][0][value]': value
    }
    encoded_query = urllib.parse.urlencode(query_params)
    url = f"{base_url}/rest/all/V1/customers/search?{encoded_query}"

    print(url)

if __name__ == "__main__":
    main()
