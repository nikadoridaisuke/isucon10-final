#!/usr/bin/env ruby

$: << File.expand_path('../lib', __dir__)
require 'logger'
require 'griffin'
require_relative '../grpc/benchmark_queue_service'
require_relative '../grpc/benchmark_report_service'
require 'database'

Xsuportal::Database.connection

Griffin::Server.configure do |c|
  c.bind '0.0.0.0'

  c.services [
    BenchmarkQueueService,
    BenchmarkReportService,
  ]

  c.workers 2

  c.logger Logger.new($stdout)
end

Griffin::Server.run