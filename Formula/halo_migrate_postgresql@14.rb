class PgMigratePostgresqlAT14 < Formula
  desc "Halo/PostgreSQL extension and CLI to make schema changes with minimal locks"
  homepage "https://github.com/HaloLab001/halo_migrate"
  sha256 "7b4d7fe8d4cd47e235e3d689cc4cfd712ec3146e834958349715583f4bbe5784"
  license "BSD-3-Clause"
  head "https://github.com/HaloLab001/halo_migrate", using: :git, branch: "master"

  depends_on "postgresql@14"

  def install
    ENV.prepend "LDFLAGS", "-L#{Formula["postgresql@14"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["postgresql@14"].opt_include}"
    ENV.prepend "PKG_CONFIG_PATH", "-I#{Formula["postgresql@14"].opt_lib}/pkgconfig"

    system "make"

    bin.install "./bin/halo_migrate"
  end

  def caveats
    <<~EOS
      To use this on a locally running version of postgres, please install the extension files:

      cp #{lib}/halo_migrate.so #{Formula["postgresql@14"].lib}
      cp #{lib}/halo_migrate--#{version}.sql #{Formula["postgresql@14"].share}/postgresql@14/extension/
      cp #{lib}/halo_migrate.control #{Formula["postgresql@14"].share}/postgresql@14/extension/

      Then run:
      `psql -c "DROP EXTENSION IF EXISTS halo_migrate cascade; CREATE EXTENSION halo_migrate" -d [dbname]`
    EOS
  end

  test do
    system bin/"halo_migrate", "--version"
  end
end
