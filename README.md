*(Please note that is a forked repository. Details of the design are described at the very end of this `README.md`. Go to https://tinytapeout.com for instructions!)*

![](../../workflows/wokwi/badge.svg)

# What is this whole thing about?

This repo is a template you can make a copy of for your own [ASIC](https://www.zerotoasiccourse.com/terminology/asic/) design using [Wokwi](https://wokwi.com/).

When you edit the Makefile to choose a different ID, the [GitHub Action](.github/workflows/wokwi.yaml) will fetch the digital netlist of your design from Wokwi.

The design gets wrapped in some extra logic that builds a 'scan chain'. This is a way to put lots of designs onto one chip and still have access to them all. You can see [all of the technical details here](https://github.com/mattvenn/scan_wrapper).

After that, the action uses the open source ASIC tool called [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/) to build the files needed to fabricate an ASIC.

# What files get made?

When the action is complete, you can [click here](https://github.com/mattvenn/wokwi-verilog-gds-test/actions) to see the latest build of your design. You need to download the zip file and take a look at the contents:

* gds_render.svg - picture of your ASIC design
* gds.html - zoomable picture of your ASIC design
* runs/wokwi/reports/final_summary_report.csv  - CSV file with lots of details about the design
* runs/wokwi/reports/synthesis/1-synthesis.stat.rpt.strategy4 - list of the [standard cells](https://www.zerotoasiccourse.com/terminology/standardcell/) used by your design
* runs/wokwi/results/final/gds/user_module.gds - the final [GDS](https://www.zerotoasiccourse.com/terminology/gds2/) file needed to make your design

# What is this specific design about?

The story of the [wolf, goat and cabbage problem](https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem), quoted from wikipedia with some emojis added for later use in visualization:

>A farmer (🧑‍🌾) went to a market and purchased a wolf (🐺), a goat (🐐), and a cabbage (🥬). On his way home, the 🧑‍🌾 came to the bank of a river (〰〰〰〰〰〰〰) and rented a boat (🛶). But crossing the river by 🛶, the 🧑‍🌾 could carry only himself and a single one of his purchases: the 🐺, the 🐐, or the 🥬.
>
>If left unattended together, the 🐺 would eat the 🐐, or the 🐐 would eat the 🥬.
>
>The 🧑‍🌾's challenge was to carry himself and his purchases to the far bank of the 〰〰〰〰〰〰〰, leaving each purchase intact.

> **Note**
> This is still work in progress. Stay tuned for the follow-up.
> To be continued...


We'll work with the following table:

|F 🧑‍🌾/🚣|W 🐺|G 🐐|C 🥬|Scenario          |Left bank|Right bank|Overall|Done?|
|----------|----|----|----|------------------|---------|----------|-------|-----|
|0         |0   |0   |0   |🐺🐐🥬🚣 〰〰〰〰〰〰〰  |✔️       |✔️        |✔️     |❌    |
|0         |0   |0   |1   |🐺🐐🚣 〰〰〰〰〰〰〰 🥬 |✔️       |✔️        |✔️     |❌    |
|0         |0   |1   |0   |🐺🥬🚣 〰〰〰〰〰〰〰 🐐 |✔️       |✔️        |✔️     |❌    |
|0         |0   |1   |1   |🐺🚣 〰〰〰〰〰〰〰 🐐🥬❌|✔️       |❌         |❌      |❌    |
|0         |1   |0   |0   |🐐🥬🚣 〰〰〰〰〰〰〰 🐺 |✔️       |✔️        |✔️     |❌    |
|0         |1   |0   |1   |🐐🚣 〰〰〰〰〰〰〰 🐺🥬 |✔️       |✔️        |✔️     |❌    |
|0         |1   |1   |0   |🥬🚣 〰〰〰〰〰〰〰 🐺🐐❌|✔️       |❌         |❌      |❌    |
|0         |1   |1   |1   |🚣 〰〰〰〰〰〰〰 🐺🐐🥬❌|✔️       |❌         |❌      |❌    |
|1         |0   |0   |0   |🐺🐐🥬❌ 〰〰〰〰〰〰〰 🚣|❌        |✔️        |❌      |❌    |
|1         |0   |0   |1   |🥬🚣 〰〰〰〰〰〰〰 🐺🐐❌|✔️       |❌         |❌      |❌    |
|1         |0   |1   |0   |🐺🥬 〰〰〰〰〰〰〰 🚣🐐 |✔️       |✔️        |✔️     |❌    |
|1         |0   |1   |1   |🐺 〰〰〰〰〰〰〰 🚣🐐🥬 |✔️       |✔️        |✔️     |❌    |
|1         |1   |0   |0   |🐐🥬❌ 〰〰〰〰〰〰〰 🚣🐺|❌        |✔️        |❌      |❌    |
|1         |1   |0   |1   |🐐 〰〰〰〰〰〰〰 🚣🐺🥬 |✔️       |✔️        |✔️     |❌    |
|1         |1   |1   |0   |🥬 〰〰〰〰〰〰〰 🚣🐺🐐 |✔️       |✔️        |✔️     |❌    |
|1         |1   |1   |1   |〰〰〰〰〰〰〰 🚣🐺🐐🥬🎉|✔️       |✔️        |✔️     |✔️   |


# Status/TODOs

I am a bit late to the party. I've started to think about the design on August, 31st - and submission deadline is already one day later on September, 1st.

🔲 Describe the design idea

🔲 Implement the design idea using Wokwi

🔲 Edit the [Makefile](Makefile) and change the WOKWI_PROJECT_ID to match the project.

🔲 Share your GDS on twitter, tag it #tinytapeout and [link me](https://twitter.com/matthewvenn)!

🔲 [Submit it to be made](https://docs.google.com/forms/d/e/1FAIpQLSc3ZF0AHKD3LoZRSmKX5byl-0AzrSK8ADeh0DtkZQX0bbr16w/viewform?usp=sf_link)

🔲 [Join the community](https://discord.gg/rPK2nSjxy8)
