module EstateConstants

  TENURE_TYPES = %w[rent sale]

  ESTATE_TYPES = %w[apartment villa house land]

  ESTATE_CLASSES = %w[economy standard premium luxurious]

  PLACES = %w[
    phuket
    samui
    bali
  ]

  PHUKET_REGIONS = %w[
    phuket_town
    phuket_kathu
    phuket_panwa
    phuket_chalong
    phuket_rawai
    phuket_nai_harn
    phuket_kata
    phuket_karon
    phuket_patong
    phuket_kalim
    phuket_kamala
    phuket_bang_tao
    phuket_surin
  ]

  SAMUI_REGIONS = %w[
    samui_maenam
    samui_bophut
    samui_choeng_mon
    samui_chaweng
    samui_lamai
    samui_hua_thanon
    samui_bang_kao
    samui_thong_krut
    samui_taling_ngam
    samui_lipa_noi
    samui_nathon
    samui_laem_yai
    samui_bang_bor
    samui_baan_tai
  ]

  BALI_REGIONS = %w[
    bali_amed
    bali_ubud
    bali_denpasar
    bali_candidasa
    bali_tanag_lot
    bali_canggu
    bali_seminyak
    bali_kerobokan
    bali_petitenget
    bali_kuta
    bali_legian
    bali_sanur
    bali_jimbaran
    bali_uluwatu
    bali_nusa_dua
    bali_benoa
    bali_bukit
    bali_pemuteran
  ]

  REGIONS = PHUKET_REGIONS + SAMUI_REGIONS + BALI_REGIONS
  REGIONS_SELECT = {
    phuket: PHUKET_REGIONS,
    samui: SAMUI_REGIONS,
    bali: BALI_REGIONS
  }
  CLEANING_PERIODS = %w[
    every_day
    every_week
    every_month
    2_times_a_week
    3_times_a_week
    4_times_a_week
    5_times_a_week
    6_times_a_week
    2_times_a_month
    3_times_a_month
  ]
end