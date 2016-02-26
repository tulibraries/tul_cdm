FactoryGirl.define do
  factory :digital_collection do
    collection_alias "p16002coll14"
    name "Franklin H. Littell Papers"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll14/images/Littell_Landing_Pagev3.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/littell_dtl.jpg"
    description <<EOT
A portion of the Franklin H. Littell papers has been digitized to offer online access.

Franklin Littell (1917-2009), emeritus professor of religion at Temple University, led a distinguished career that spanned more than seventy years. He was a pacifist and activist, proponent of the Christian Laity and an advocate for new religious movements, an historian, political commentator and supporter of the State of Israel. He devoted ten years to work with the Protestant Churches and Laity in US occupied Germany and more than fifty years to the study and remembrance of the Holocaust and German Church Struggle. Though his activities and affiliations changed over time, he maintained strong beliefs in interfaith understanding and religious liberty his entire life.

Currently, manuscripts of most of Littell's "Speeches, lectures, and article manuscripts" dating from 1940 to 2002 are available digitally, though more will be added. Also available are correspondence and administrative records relating to his work with the National Council of Methodist Youth from 1934 to 1944.
EOT
    short_description "Franklin Littell\'s Papers"
    is_private false
    allowed_ip_addresses ""
    finding_aid_link "http://example.com/finding_aid"
    catalog_record_link "http://example.com/catalog_record"
  end

  factory :updated_digital_object, class: DigitalCollection do
    collection_alias "NEWCOLLECTION"
    name "Updated Collection"
    image_url "http://localhost/collection_image.jpg"
    thumbnail_url "http://localhost/thumbnail_image.jpg"
    description "Updated collection description"
    short_description "Short description"
    is_private true
    allowed_ip_addresses "127.0.0.1, 10.1.1.2, 192.168.1.3"
  end

  factory :invalid_digital_collection, class: DigitalCollection do
    name "Franklin H. Littell Papers"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll14/images/Littell_Landing_Pagev3.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/littell_dtl.jpg"
    description ""
    short_description ""
    is_private true
    allowed_ip_addresses "127.0.0.1, 10.1.1.1, 192.168.1.2"
  end

  factory :private_digital_collection, class: DigitalCollection do
    collection_alias "p16002coll11"
    name "Private Digital Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll11/images/private.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/private.jpg"
    description ""
    short_description ""
    is_private true
    allowed_ip_addresses "127.0.0.1, 10.1.1.1, 192.168.1.2"
  end

  factory :private_digital_collection_allowed, class: DigitalCollection do
    collection_alias "p16002coll11"
    name "Allowed Private Digital Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll11/images/private.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/private.jpg"
    description ""
    short_description ""
    is_private true
    allowed_ip_addresses "0.0.0.0"
  end

  factory :private_digital_collection_denied, class: DigitalCollection do
    collection_alias "p16002coll11"
    name "Denied Private Digital Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll11/images/private.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/private.jpg"
    description ""
    short_description ""
    is_private true
    allowed_ip_addresses "1.1.1.1"
  end

  factory :custom_collection, class: DigitalCollection do
    collection_alias ""
    name "Custom Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll14/images/Littell_Landing_Pagev3.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/littell_dtl.jpg"
    description "A combination of muiltiple collections"
    short_description "multiple collections"
    is_private false
    allowed_ip_addresses ""
    custom_url "/?utf8=✓&f%5Bdigital_collection_sim%5D%5B%5D=Stereotypical+Images+Teaching+Collection&search_field=digital_collection&q=p15037coll1+OR+p16002coll7"
  end

  factory :proxy_collection, class: DigitalCollection do
    collection_alias "p16002coll8"
    name "Proxy Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll8/images/TU_Press_Landing_Page_V3.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/tu_press_dtl.jpgg"
    description "A proxy collections"
    short_description "proxy collections"
    is_private false
    allowed_ip_addresses ""
    custom_url "/?utf8=✓&f%5Bdigital_collection_sim%5D%5B%5D=Stereotypical+Images+Teaching+Collection&search_field=digital_collection&q=p15037coll1+OR+p16002coll7"
    proxy_url_prefix "http://libproxy.temple.edu/login?url="
  end

  factory :proxy_custom_collection, class: DigitalCollection do
    collection_alias "p16002coll8"
    name "Proxy Collection"
    image_url "http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll8/images/TU_Press_Landing_Page_V3.jpg"
    thumbnail_url "http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/tu_press_dtl.jpgg"
    description "A proxy collections"
    short_description "proxy collections"
    is_private false
    allowed_ip_addresses ""
    custom_url "http://example.com"
    proxy_url_prefix "http://libproxy.temple.edu/login?url="
    is_custom_landing_page true
  end

  factory :digital_collections_list, class: DigitalCollection do

    example_items = [
      { collection_alias: 'p15037coll1',   name: 'Temple Sheet Music Collections' },
      { collection_alias: 'p15037coll2',   name: 'SCRC Film and Video' },
      { collection_alias: 'p15037coll7',   name: 'George D. McDowell Philadelphia Evening Bulletin Clippings' },
      { collection_alias: 'p15037coll12',  name: 'Temple Undergraduate Research Prize Winners' },
      { collection_alias: 'p15037coll14',  name: 'SCRC Books and Pamphlets' },
      { collection_alias: 'p16002coll1',   name: 'SCRC Audio' },
      { collection_alias: 'p16002coll7',   name: 'Blockson Ephemera' },
      { collection_alias: 'p16002coll8',   name: 'Temple University Press E-Books' },
      { collection_alias: 'p16002coll9',   name: 'Allied Posters of World War I' },
      { collection_alias: 'p16002coll14',  name: 'Franklin H. Littell Papers' },
      { collection_alias: 'p245801coll12', name: 'Temple University Yearbooks' }
    ]

    sequence :collection_alias do |n|
      example_items[n-1][:collection_alias]
    end
    sequence :name do |n|
      example_items[n-1][:name]
    end
  end

end
