# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Digital Colleciton Seed
DigitalCollection.delete_all;

collections = [
  {
  collection_alias: 'p16002coll9',
  name:             'Allied Posters of World War I',
  thumbnail_url:    'http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/alliedposters_dtl.jpg',
  image_url:        'http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll9/images/pt160014_lnd.jpg',
  priority:         11,
  description:      <<-END.gsub(/^ {6}/, '')
      <p><span>This collection of over 1,500 World War I posters in Temple University Libraries' Special Collections Research Center was donated by George F. Tyler in 1937. The posters provide a graphic portrayal of Allied propaganda used to educate the public and enlist support for the war effort. In addition, they serve as examples of the art, design, and printing techniques of the period.</span></p>
      <p><span>An <a href="http://gamma.library.temple.edu/exhibits/exhibits/show/george-tyler-wwi-poster-exhibi" target="new">exhibition</a> of a selection of the posters is accompanied by primary source material and commentary intended to provide additional context, insight, and interpretation.</span></p>
    END
  },
  {
  collection_alias: 'p16002coll14',
  name:             'Franklin H. Littell Papers',
  thumbnail_url:    'http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/littell_dtl.jpg',
  image_url:        'http://digital.library.temple.edu/ui/custom/default/collection/coll_p16002coll14/images/Littell_Landing_Pagev3.jpg',
  priority:         22,
  description:      <<-END.gsub(/^ {6}/, '')
      <p>A portion of the Franklin H. Littell papers has been digitized to offer online access.</p>
      <p>Franklin Littell (1917-2009), emeritus professor of religion at Temple University, led a distinguished career that spanned more than seventy years. He was a pacifist and activist, proponent of the Christian Laity and an advocate for new religious movements, an historian, political commentator and supporter of the State of Israel. He devoted ten years to work with the Protestant Churches and Laity in US occupied Germany and more than fifty years to the study and remembrance of the Holocaust and German Church Struggle. Though his activities and affiliations changed over time, he maintained strong beliefs in interfaith understanding and religious liberty his entire life.</p>
      <p">Currently, manuscripts of most of Littell's "Speeches, lectures, and article manuscripts" dating from 1940 to 2002 are available digitally, though more will be added. Also available are correspondence and administrative records relating to his work with the National Council of Methodist Youth from 1934 to 1944.</p>
    END
  },
  {
  collection_alias: 'p15037coll7',
  name:             'George D. McDowell Philadelphia Evening Bulletin Clippings',
  thumbnail_url:    'http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/bul_clip_dtl.jpg',
  image_url:        'http://digital.library.temple.edu/ui/custom/default/collection/coll_p15037coll7/images/Clippings_widescreen.jpg',
  priority:         23,
  description:      <<-END.gsub(/^ {6}/, '')
      <p><span>Search here for sample clippings from the <strong>George D. McDowell Philadelphia Evening Bulletin Collection </strong>digitized in 2010 - 2013.</span></p>
    END
  },
  {
  collection_alias: 'p15037coll1',
  name:             'Temple Sheet Music Collections',
  thumbnail_url:    'http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/sm00244_dtl.jpg',
  image_url:        'http://digital.library.temple.edu/ui/custom/default/collection/coll_p15037coll1/images/Sheet_Music_Widescreen_Border.jpg',
  priority:         73,
  description:      <<-END.gsub(/^ {6}/, '')
      <p><span>This sheet music published from the early 19th to early 20th centuries, from Temple University Libraries’ collections, contains lithographed and engraved cover art. These covers show remarkable designs and document developing printing techniques throughout more than 100 years. The collections include popular dances and songs, comic tunes that reveal the ironies and anxieties of the time, and music commemorating great exhibitions and honoring heroes and stars.</span></p>
    END
  },
  {
  collection_alias: 'p15037coll12',
  name:             'Temple Undergraduate Research Prize Winners',
  thumbnail_url:    'http://digital.library.temple.edu/ui/custom/default/collection/default/resources/custompages/home/co_identity_dtl.jpg',
  image_url:        'http://digital.library.temple.edu/ui/custom/default/collection/coll_p15037coll12/images/LibPrizelanding2013.jpg',
  priority:         81,
  description:      <<-END.gsub(/^ {6}/, '')
      <p><span>The Library Prize for Undergraduate Research was established in 2004 to encourage the use of Library resources, to enhance the development of library research techniques, and to honor the best research projects produced each year by Temple University undergraduate students. Up to three projects are selected each year to win $1000. Winning entries exhibit: originality, depth, breadth, or sophistication in the use of library collections; exceptional ability to select, evaluate, synthesize, and utilize library resources in the creation of a project in any media; and evidence of personal growth through the acquisition of newfound knowledge.</span></p>
      <p><span>Also included in this collection are the winning entries for <strong>The Library Prize for Undergraduate Research on Sustainability &amp; the Environment</strong>. Established in the 2010-2011 academic year by Temple Libraries and Gale, a leading organization in e-research and educational publishing, this prize encourage undergraduate research and projects in the area of sustainability. Up to two projects are selected each year to win $1000.</span></p>
    END
  },
  {
  collection_alias: 'p16002coll1',
  name:             'SCRC Audio',
  priority:         112,
  description:      <<-END.gsub(/^ {6}/, '')
      <p>The SCRC Audio digital collection contains audio files from holdings in the Special Collections Research Center (SCRC). Some of the objects in this collection are better contextualized in the following featured collection(s):</p>
      <ul>
        <li>
          <div class="cdm_style" style="margin-top: 10px;"><a href="http://northerncity.library.temple.edu/"> Civil Rights in a Northern City: Philadelphia</a></div>
        </li>
      </ul>
    END
  },
  {
  collection_alias: 'p15037coll2',
  name:             'SCRC Film and Video',
  priority:         131,
  description:      <<-END.gsub(/^ {6}/, '')
    <p class="cdm_style" style="margin-top: 10px;">The SCRC Film and Video digital collection contains video files from holdings in the Special Collections Research Center (SCRC). Some of the objects in this collection are better contextualized in the following featured collection(s):</p>
    <ul>
      <li>
        <div class="cdm_style" style="margin-top: 10px;"><a href="http://northerncity.library.temple.edu/"> Civil Rights in a Northern City: Philadelphia</a></div>
      </li>
    </ul>
  END
  },
  {
  collection_alias: 'p15037coll14',
  name:             'SCRC Books and Pamphlets',
  priority:         131,
  description:      <<-END.gsub(/^ {6}/, '')
    <p>The SCRC Books and Pamphlets digital collection contains pamphlets and related materials from holdings in the Special Collections Research Center (SCRC). Some of the objects in this collection are better contextualized in the following featured collection(s):</p>
    <ul>
      <li>
        <div class="cdm_style" style="margin-top: 10px;"><a href="http://northerncity.library.temple.edu/">Civil Rights in a Northern City: Philadelphia</a></div>
      </li>
    </ul>
    <ul>
      <li>
        <div class="cdm_style" style="margin-top: 10px;"><a href="/cdm/ywcamain/"> YWCA Philadelphia Branches</a></div>
      </li>
    </ul>
    <p>Other sets in this collection: &nbsp;</p>
    <ul>
      <li>
        <div class="cdm_style"><a href="/cdm/search/collection/p15037coll14/searchterm/Beth%20Heinly%20Zine%20Collection/field/digitb/mode/all/conn/and/order/title">Beth Heinly Zine Collection</a></div>
      </li>
    </ul>
  END
  }
]

collections.each do |collection|
  DigitalCollection.create(collection)
end
