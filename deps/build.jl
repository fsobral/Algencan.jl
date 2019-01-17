using BinDeps

@BinDeps.setup

libmetis = library_dependency("libmetis")
udir = "metis-4.0.3"
metis_dir = joinpath(BinDeps.depsdir(libmetis), "src", udir)
provides(Sources, URI("http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/OLD/metis-4.0.3.tar.gz"), libmetis, unpacked_dir=udir)

# ma57_src = ENV["MA57_SOURCE"]
# libhsl_ma57 = library_dependency("libhsl_ma57")
# ma57_dir = joinpath(BinDeps.depsdir(libhsl_ma57), "src", "hsl_ma57-5.2.0")

# src_dir = joinpath(BinDeps.depsdir(libhsl_ma57), "src")
src_dir = joinpath(BinDeps.depsdir(libmetis), "src")

# metis
provides(SimpleBuild,
  (@build_steps begin
    GetSources(libmetis)
    @build_steps begin
      ChangeDirectory(src_dir)
      `tar xvf downloads/metis-4.0.3.tar.gz --directory=src`
    end
  end), libmetis, os = :Linux
)

# # HSL
# provides(SimpleBuild, 
#   (@build_steps begin
#       CreateDirectory(ma57_dir)
#       `tar xvf $ma57_src --directory=$src_dir`
#       @build_steps begin
#         ChangeDirectory(ma57_dir)
#         `patch -p1 <../../patches/patch_ma57.txt`
#         `./configure --prefix=$ma57_dir CFLAGS=-fPIC FCFLAGS=-fPIC `
#         `make`
#         `make install`
#       end
#       @build_steps begin
#         ChangeDirectory(joinpath(ma57_dir, "lib"))
#         `gcc --shared -o libhsl_ma57.so libhsl_ma57.a`
#       end
#   end), libhsl_ma57, os = :Linux
# )

@BinDeps.install Dict(:libmetis => :libmetis)
