{
  "targets": [
    {
      "target_name": "addon",
      "sources": [
       "src-cpp/addon.cc"
       ],
      "include_dirs": [
        "<!(node -e \"require('nan')\")"
      ]
    }
  ]
}
