module.exports = function(grunt) {
  grunt.initConfig({
    less: {
      development: {
        files: {
          "web/css/styles.css": "web/less/styles.less" // target.css: source.less
        }
      },
      production: {
        options: {
          compress: true,
          cleancss: true,
        },
        files: {
          "web/css/styles.css": "web/less/styles.less"
        }
      }
    },
    watch: {
      styles: {
        files: ['web/less/**/*.less'], // which files to watch
        tasks: ['less:development'],
        options: {
          nospawn: true
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['watch']);
};