MRuby::Build.new do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  conf.cc do |cc|
    cc.flags = %w(/c /nologo /W3 /we4013 /MT /O2 /D_CRT_SECURE_NO_WARNINGS)
  end

  conf.linker do |linker|
    # ignore many warning for linking Allegro5
    linker.link_options << '/ignore:4099'
  end

  conf.gembox 'full-core'

  conf.gem 'mruby-minigame' do |g|
    g.cc.defines << 'ALLEGRO_STATICLINK'
    g.cc.include_paths << ENV['A5_INC_DIR']
    g.linker.library_paths << ENV['A5_LIB_DIR'] << ENV['A5DEPS_LIB_DIR']
    g.linker.libraries = %w(allegro_monolith-static dumb FLAC ogg vorbis vorbisfile freetype jpeg libpng16 zlib opengl32 user32 ole32 gdi32 winmm psapi shell32 shlwapi)
  end
end


MRuby::Build.new('test') do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  enable_debug
  conf.enable_bintest
  conf.enable_test

  conf.gembox 'full-core'

  conf.file_separator = '/'
end
