# -*- encoding : utf-8 -*-
module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        def initialize(authors)
          @authors = authors
        end

        def commits_sum_by_author_by_date(authors = nil)
          Chart.new do |f|
            f.multi_date_chart(
                data: (authors || @authors.sort_by { |author| -author.commits.size }).map { |author| {name: author.name, data: author.commits_sum_by_date} },
                title: :lines_by_date.t,
                y_text: :lines.t
            )
          end
        end

        [:insertions, :deletions, :changed_lines].each do |method|
          define_method "#{method}_by_author_by_date" do |authors = nil|
            Chart.new do |f|
              f.multi_date_chart(
                  data: (authors || @authors.sort_by { |author| -author.send(method) }.map { |author| {name: author.name, data: author.send("#{method}_by_date")} },
                  title: :lines_by_date.t,
                  y_text: :lines.t
              )
            end
          end
        end

      end
    end
  end
end
