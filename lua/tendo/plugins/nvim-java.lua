return {
  'nvim-java/nvim-java',
  config = function()
    local function first_marker_dir(markers, path)
      local marker = vim.fs.find(markers, {
        path = path,
        upward = true,
        stop = vim.env.HOME,
      })[1]

      return marker and vim.fs.dirname(marker) or nil
    end

    local function root_from_package(fname)
      local package_name
      for line in io.lines(fname) do
        package_name = line:match '^%s*package%s+([%w_.]+)%s*;'
        if package_name then
          break
        end
      end

      if not package_name then
        return nil
      end

      local package_path = package_name:gsub('%.', '/')
      local dir = vim.fs.normalize(vim.fs.dirname(fname))
      if vim.endswith(dir, package_path) then
        return (dir:sub(1, #dir - #package_path):gsub('/$', ''))
      end

      return nil
    end

    local function java_root_dir(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local file_dir = vim.fs.dirname(fname)

      local project_root = first_marker_dir({
        '.classpath',
        '.project',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        'settings.gradle',
        'settings.gradle.kts',
        'build.xml',
      }, file_dir)

      on_dir(project_root or root_from_package(fname) or first_marker_dir({ '.git' }, file_dir) or file_dir)
    end

    require('java').setup()

    vim.lsp.config('jdtls', {
      root_dir = java_root_dir,
      settings = {
        java = {
          project = {
            sourcePaths = { '.' },
            referencedLibraries = { 'lib/**/*.jar' },
          },
          configuration = {
            runtimes = {
              {
                name = 'JavaSE-17',
                path = '/usr/lib/jvm/java-17-temurin-jdk',
                default = true,
              },
            },
          },
        },
      },
    })

    vim.lsp.enable 'jdtls'
  end,
}
