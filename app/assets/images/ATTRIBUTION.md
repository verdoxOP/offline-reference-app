# Image credits

All images are from Wikimedia Commons, openly licensed, resized/re-encoded
for the app. CC BY / CC BY-SA license requires this attribution to ship with
the app; it isn't yet surfaced in the UI — that's a follow-up (an in-app
"credits" screen).

| File | Source title | Author | License |
|---|---|---|---|
| water-voedsel.jpg | Canned and pickled goods.jpg | Kerem Delialioğlu | CC BY-SA 4.0 |
| licht-stroom.jpg | Led flashlight.jpg | Alanelavumkunel | CC BY-SA 4.0 |
| communicatie.jpg | Eton FR300 emergency crank radio.jpg | Morn | CC BY-SA 4.0 |
| documenten-geld.jpg | Euro banknotes in wallet.jpg | Santeri Viinamäki | CC BY-SA 4.0 |
| noodplan.jpg | Evacuation route sign3.jpg | Pieria | Public domain |
| vluchttas.jpg | FEMA - 37174 - Emergency Preparedness "ready to go" kit.jpg | American Red Cross | Public domain |
| gezondheid-ehbo.jpg | Erste Hilfe 003 2026 02 17.jpg | Friedrich Haag | CC BY-SA 4.0 |
| nooddiensten.jpg | Emergency Service vehicles at Rockhampton Hospital.jpg | RegionalQueenslander | CC BY-SA 4.0 |
| noodsteunpunten.jpg | Suburban Hospital main entrance Bethesda MD.jpg | G. Edward Johnson | CC BY 4.0 |
| watertappunten.jpg | Jointhepipe public water tap, Delftweg - Rotterdam (2020) 01.jpg | Donald Trung Quoc Don | CC BY-SA 4.0 |
| verzamelpunten.jpg | Assembly point sign.jpg | Ibrahim Husain Meraj | CC BY-SA 4.0 |
| faq-112-bellen.jpg | Hand-smartphone-technology-calling.jpg | Unknown author | CC0 |
| faq-eten-bewaren.jpg | EFTA00001876 - Well-organized kitchen pantry.jpg | Federal Bureau of Investigation | Public domain |
| faq-regenwater.jpg | Red rain barrel.jpg | Cornellrockey | CC BY-SA 4.0 |
| faq-info-zonder-internet.jpg | Braun T 52 radio.jpg | Kaldari | CC0 |

No image was sourced for `faq-water-filteren` or `faq-112-onbereikbaar` —
search didn't turn up a clearly relevant, openly-licensed photo for either;
those topics use the category icon only.

Source: https://commons.wikimedia.org — each file's full credit/license page
is at `https://commons.wikimedia.org/wiki/File:<source title>`.

## kaart_tilburg.jpg

Self-rendered from real OpenStreetMap data (roads, canal, and POI
coordinates for hospitals/police/fire stations/drinking water points),
queried via the Overpass API and drawn with Pillow — not a fetched map
tile. Map data © OpenStreetMap contributors, https://www.openstreetmap.org/copyright,
available under the Open Database License (ODbL).

## assets/tiles/ and assets/data/kaart_locations.json

The Kaart tab's interactive offline map. `assets/tiles/` holds real OSM
raster tiles for the Tilburg city centre (zoom 13-15, bbox roughly
51.535,5.030 to 51.585,5.140), fetched once at packaging time from
`tile.openstreetmap.org` and bundled with the app — no tile is ever
fetched at runtime. `kaart_locations.json` holds real hospital/police/
community-support-point locations for the same area, queried once via the
Overpass API. Map data © OpenStreetMap contributors,
https://www.openstreetmap.org/copyright, available under the Open Database
License (ODbL).

