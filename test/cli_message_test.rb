require 'methadone'
require 'test_helper'
require File.join(File.dirname(__FILE__), '..', 'lib/sifttter_redux/cli_message.rb')

include Methadone::CLILogging

class CLIMessageTest < Test::Unit::TestCase
  def test_error_message
    assert_output('---> ERROR: test'.red + "\n") { SifttterRedux::CLIMessage.error('test', false) }
  end

  def test_info_message
    assert_output('---> INFO: test'.blue + "\n") { SifttterRedux::CLIMessage.info('test', false) }
  end

  def test_info_block_single_line
    assert_output("---> INFO: start".blue + "body\n" + 'end'.blue + "\n") do
      SifttterRedux::CLIMessage.info_block('start', 'end', false, false) { puts 'body' }
    end
  end

  def test_info_block_multiline
    assert_output("---> INFO: start".blue + "\nbody\n" + '---> INFO: end'.blue + "\n") do
      SifttterRedux::CLIMessage.info_block('start', 'end', true, false) { puts 'body' }
    end
  end
  
  def test_info_block_no_block
    assert_raise ArgumentError do
      SifttterRedux::CLIMessage.info_block('start', 'end', true, false)
    end
  end

  def test_prompt
    assert_equal(SifttterRedux::CLIMessage.prompt('Pick the default option', 'default'), 'default')
  end

  def test_section_message
    assert_output('#### test'.purple + "\n") { SifttterRedux::CLIMessage.section('test', false) }
  end

  def test_section_block_single_line
    assert_output("#### section".purple + "\nbody\n") do
      SifttterRedux::CLIMessage.section_block('section', true, false) { puts 'body' }
    end
  end

  def test_success_message
    assert_output('---> SUCCESS: test'.green + "\n") { SifttterRedux::CLIMessage.success('test', false) }
  end

  def test_warning_message
    assert_output('---> WARNING: test'.yellow + "\n") { SifttterRedux::CLIMessage.warning('test', false) }
  end
end
