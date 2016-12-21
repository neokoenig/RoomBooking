module.exports = function(grunt) {

  grunt.initConfig({
    bp: 'bower_components',
    ss: 'public/stylesheets',
    js: 'public/javascripts',
    pkg: grunt.file.readJSON('package.json'),

    // Task configuration
    less: {
        css: {
            options: {
              compress: false,  //minifying the result
            },
             files: {
                  "<%= ss %>/cms.css":"<%= ss %>/less/core/cms.less"
            }
        }
    },

    cssmin: {
      options: {
        banner: "/*! <%= pkg.name %> minified CSS file generated @ <%= grunt.template.today('dd-mm-yyyy') %> */\n"
      },
      css: {
        files: {
         "<%= ss %>/cms.min.css": [ "<%= ss %>/cms.css" ]
         }
      }
        },

    clean : {
      css : {
         src: ["<%= ss %>/cms.css", "<%= ss %>/cms.min.css"]
      },
      js: {
         src: ["<%= js %>/cms.js","<%= js %>/cms.min.js","<%= js %>/cms-admin.js","<%= js %>/cms-admin.min.js"]
      }
    },

    concat : {
      options: {
        separator: ';',
      },
      frontend: {
        src: [
         // jQuery
         '<%= bp %>/jquery/dist/jquery.js',
        // Bootstrap individual components: delete what we don't need/use
          //'<%= bp %>/bootstrap/js/alert.js',
          //'<%= bp %>/bootstrap/js/button.js',
          //'<%= bp %>/bootstrap/js/carousel.js',
          //'<%= bp %>/bootstrap/js/collapse.js',
          //'<%= bp %>/bootstrap/js/dropdown.js',
          //'<%= bp %>/bootstrap/js/modal.js',
          //'<%= bp %>/bootstrap/js/tooltip.js',
          //'<%= bp %>/bootstrap/js/popover.js',
          //'<%= bp %>/bootstrap/js/tab.js',
          //'<%= bp %>/bootstrap/js/transition.js',
        // Vendor
          //'<%= bp %>/moment/moment.js',
          //'<%= bp %>/fullcalendar/dist/fullcalendar.js',
          //'<%= bp %>/eonasdan-bootstrap-datetimepicker/src/js/bootstrap-datetimepicker.js',
          //'<%= bp %>/bootstrapvalidator/dist/js/bootstrapValidator.js',
          //'<%= bp %>/minicolors/jquery.minicolors.js',
          //'<%= bp %>/jquery-ui/jquery-ui.js',
          //'<%= bp %>/gridmanager/src/gridmanager.js',
          //'<%= bp %>/bootbox/bootbox.js',
          //'<%= bp %>/fullcalendar/dist/lang-all.js',
        // Custom Front end JS - all your custom JS here!
          '<%= js %>/main.js'
        ],
        dest: '<%= js %>/cms.js'
      }
    },



    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        eqnull: true,
        browser: true,
        globals: {
          jQuery: true
        },
      },
      all: ['Gruntfile.js', '<%= js %>/frontend.js','<%= js %>/backend.js']
    },

    uglify : {
      frontend: {
        files: {
          '<%= js %>/cms.min.js' : [ '<%= js %>/cms.js' ]
        }
      }
    },

    imagemin: {
    png: {
      options: {
        optimizationLevel: 7
      },
      files: [
        {
          // Set to true to enable the following options…
          expand: true,
          // cwd is 'current working directory'
          cwd: 'public/images/',
          src: ['**/*.png'],
          // Could also match cwd line above. i.e. project-directory/img/
          dest: 'public/images/',
          ext: '.png'
        }
      ]
    },
    jpg: {
      options: {
        progressive: true
      },
      files: [
        {
          // Set to true to enable the following options…
          expand: true,
          // cwd is 'current working directory'
          cwd: 'public/images/',
          src: ['**/*.jpg'],
          // Could also match cwd. i.e. project-directory/img/
          dest: 'public/images/',
          ext: '.jpg'
        }
      ]
    }
  } ,

    watch: {
      js: {
        files: ['<%= js %>/backend.js', '<%= js %>/frontend.js'],
        tasks: ['js']
      },
      css: {
        files: ['<%= ss %>/less/core/*.less', '<%= ss %>/less/site/*.less'],
        tasks: ['css']
      }
    }


  });

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-injector');
  grunt.loadNpmTasks('grunt-rev');

  grunt.registerTask('css', ['clean:css', 'less:css', 'cssmin:css']);
  grunt.registerTask('js', ['jshint', 'clean:js', 'concat', 'uglify']);
  grunt.registerTask('default', ['watch']);
};
