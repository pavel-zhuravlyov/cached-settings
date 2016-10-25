# frozen_string_literal: true
# frozen_string_literal: true
require 'spec_helper'

require 'test_app/app/models/cached_setting'
require 'redis'

describe CachedSettings do
  let(:redis) { MockRedis.new }

  before do
    CachedSettings.configure_storage do |config|
      config.redis_instance = redis
    end
  end

  describe '#create' do
    it 'creates Setting record' do
      expect(described_class.create(:test, 5)).to be_truthy

      expect(CachedSetting.count).to eq 1
      expect(CachedSetting.where(key: 'test', value: '5').count).to eq 1
    end
  end

  describe '#get' do
    context 'when setting exists' do
      before { FactoryGirl.create :cached_setting, key: 'test', value: '5' }

      it 'gets setting value and caches value' do
        expect(described_class.get('test')).to eq '5'
        CachedSetting.first.update(value: 'other')
        expect(described_class.get('test')).to eq '5' # caching test

        expect(redis.get('setting:test')).to eq '5'
      end
    end

    context 'when setting does not exist' do
      context 'when there is no default value' do
        it 'raises exception' do
          expect { described_class.get('test') }
            .to raise_exception(StandardError, "CachedSetting 'test' not found")
        end
      end

      context 'when default value specified' do
        it 'returns default value' do
          expect(described_class.get('test', default: 'default_value')).to eq 'default_value'
        end
      end
    end
  end

  describe '#set' do
    context 'when there is no such setting' do
      it 'raises exception' do
        expect { described_class.set('test', 'value') }
          .to raise_exception(StandardError, "CachedSetting 'test' not found")
      end
    end

    context 'when setting exists' do
      before { FactoryGirl.create :cached_setting, key: 'test', value: 'old' }

      it 'sets new value to db and cache' do
        expect(described_class.set('test', 'new')).to be_truthy

        expect(CachedSetting.count).to eq 1
        expect(CachedSetting.where(key: 'test', value: 'new').count).to eq 1
        expect(redis.get('setting:test')).to eq 'new'
      end
    end
  end

  describe 'full flow' do
    it 'works' do
      described_class.create('page_limit', 5)
      expect(described_class.get('page_limit')).to eq '5'
      described_class.set('page_limit', 10)
      expect(described_class.get('page_limit')).to eq '10'
      expect(described_class.get('page_limit', default: 5)).to eq '10'
      expect(described_class.get('other_key', default: 5)).to eq '5'
    end
  end
end
